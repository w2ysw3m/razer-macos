#include "NativeRazerBridgeC.h"

#include <stdbool.h>
#include <stdlib.h>

#include "razerdevice.h"
#include "razermouse_driver.h"

extern bool is_mouse(IOUSBDeviceInterface **usb_dev);

static RazerDevices cached_devices = {0};
static bool has_cached_devices = false;

static void close_cached_devices(void) {
  if (has_cached_devices) {
    closeAllRazerDevices(cached_devices);
    cached_devices.devices = NULL;
    cached_devices.size = 0;
    has_cached_devices = false;
  }
}

static RazerDevice *find_cached_device(int internalDeviceId) {
  if (!has_cached_devices) {
    cached_devices = getAllRazerDevices();
    has_cached_devices = true;
  }

  for (int index = 0; index < cached_devices.size; ++index) {
    if (cached_devices.devices[index].internalDeviceId == internalDeviceId) {
      return &cached_devices.devices[index];
    }
  }

  return NULL;
}

int NativeRazerRefreshMice(NativeRazerMouseSnapshot *snapshots, int maxSnapshots) {
  if (snapshots == NULL || maxSnapshots <= 0) {
    return 0;
  }

  close_cached_devices();
  cached_devices = getAllRazerDevices();
  has_cached_devices = true;

  int count = 0;
  for (int index = 0; index < cached_devices.size && count < maxSnapshots; ++index) {
    RazerDevice *device = &cached_devices.devices[index];
    if (device->usbDevice == NULL || !is_mouse(device->usbDevice)) {
      continue;
    }

    NativeRazerMouseSnapshot snapshot = {0};
    snapshot.internalDeviceId = device->internalDeviceId;
    snapshot.productId = device->productId;
    snapshot.dpi = razer_attr_read_dpi(device->usbDevice);
    snapshot.pollingRate = razer_attr_read_poll_rate(device->usbDevice);

    char batteryBuffer[4] = {0};
    razer_attr_read_get_battery(device->usbDevice, batteryBuffer);
    int rawBattery = atoi(batteryBuffer);
    snapshot.batteryLevel = rawBattery > 0 ? (rawBattery * 100) / 255 : -1;

    char chargingBuffer[2] = {0};
    razer_attr_read_is_charging(device->usbDevice, chargingBuffer);
    snapshot.charging = atoi(chargingBuffer) > 0 ? 1 : 0;

    snapshots[count] = snapshot;
    count += 1;
  }

  return count;
}

int NativeRazerSetMouseDPI(int internalDeviceId, unsigned short dpi) {
  RazerDevice *device = find_cached_device(internalDeviceId);
  if (device == NULL || device->usbDevice == NULL) {
    return -1;
  }

  razer_attr_write_dpi(device->usbDevice, dpi, dpi);
  return 0;
}

int NativeRazerSetMousePollingRate(int internalDeviceId, unsigned short pollingRate) {
  RazerDevice *device = find_cached_device(internalDeviceId);
  if (device == NULL || device->usbDevice == NULL) {
    return -1;
  }

  razer_attr_write_poll_rate(device->usbDevice, pollingRate);
  return 0;
}

void NativeRazerShutdown(void) {
  close_cached_devices();
}
