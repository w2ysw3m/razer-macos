import NativeRazerCore
import SwiftUI

struct DeviceControlsView: View {
  let device: NativeDevice
  let onSetDPI: (Int) -> Void
  let onSetPollingRate: (Int) -> Void

  @State private var draftDPI: Double = 1_600
  @State private var draftPollingRate: Int = 1_000
  @Environment(\.appLanguage) private var language

  var body: some View {
    GroupBox(AppText.string(.deviceControls, language: language)) {
      VStack(alignment: .leading, spacing: 18) {
        if let dpiConfiguration = device.controlConfiguration.dpi {
          dpiControl(dpiConfiguration)
        }

        if device.controlConfiguration.supportsPollingRate {
          pollingRateControl
        }

        if device.capabilities.contains(.battery) {
          batteryStatus
        }

        if device.controlConfiguration.supportsStaticColor {
          lightingControls
        }
      }
      .onAppear {
        syncDrafts()
      }
      .onChange(of: device) {
        syncDrafts()
      }
    }
  }

  private func dpiControl(_ configuration: DPIConfiguration) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Label(AppText.string(.capabilityDPI, language: language), systemImage: "scope")
          .font(.headline)

        Spacer()

        Text("\(Int(draftDPI))")
          .monospacedDigit()
          .foregroundStyle(.secondary)
      }

      Slider(
        value: $draftDPI,
        in: Double(configuration.min)...Double(configuration.max),
        step: Double(configuration.step)
      )

      HStack {
        Text("\(configuration.min)")
        Spacer()
        Text("\(configuration.max)")
      }
      .font(.caption)
      .foregroundStyle(.secondary)

      Button {
        onSetDPI(Int(draftDPI))
      } label: {
        Label(AppText.string(.setDPI, language: language), systemImage: "checkmark.circle")
      }
      .buttonStyle(.borderedProminent)
    }
  }

  private var pollingRateControl: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.pollingRate, language: language), systemImage: "speedometer")
        .font(.headline)

      Picker(AppText.string(.pollingRate, language: language), selection: $draftPollingRate) {
        ForEach(device.controlConfiguration.pollingRates, id: \.self) { rate in
          Text("\(rate) Hz").tag(rate)
        }
      }
      .pickerStyle(.segmented)

      Button {
        onSetPollingRate(draftPollingRate)
      } label: {
        Label(AppText.string(.savePollingRate, language: language), systemImage: "checkmark.circle")
      }
    }
  }

  private var batteryStatus: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.battery, language: language), systemImage: "battery.75percent")
        .font(.headline)

      if let batteryLevel = device.controlState.batteryLevel {
        ProgressView(value: Double(batteryLevel), total: 100) {
          Text(
            device.controlState.isCharging == true
              ? AppText.string(.charging, language: language)
              : AppText.string(.battery, language: language)
          )
        } currentValueLabel: {
          Text("\(batteryLevel)%")
        }
      } else {
        Text(AppText.string(.batteryStatusUnavailable, language: language))
          .foregroundStyle(.secondary)
      }
    }
  }

  private var lightingControls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Label(AppText.string(.lighting, language: language), systemImage: "lightbulb")
        .font(.headline)

      Text(AppText.string(.lightingUnavailable, language: language))
        .foregroundStyle(.secondary)
    }
  }

  private func syncDrafts() {
    if let dpi = device.controlState.dpi {
      draftDPI = Double(dpi)
    }

    if let pollingRate = device.controlState.pollingRate,
       device.controlConfiguration.pollingRates.contains(pollingRate) {
      draftPollingRate = pollingRate
    } else if let firstRate = device.controlConfiguration.pollingRates.first {
      draftPollingRate = firstRate
    }
  }
}
