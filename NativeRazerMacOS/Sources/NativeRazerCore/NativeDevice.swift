public struct NativeDevice: Identifiable, Equatable, Sendable {
  public let id: String
  public let name: String
  public let productId: String
  public var connection: String
  public let capabilities: [DeviceCapability]
  public var bridgeStatus: String
  public var hardwareInternalId: Int?
  public var controlConfiguration: DeviceControlConfiguration
  public var controlState: DeviceControlState

  public init(
    id: String,
    name: String,
    productId: String,
    connection: String,
    capabilities: [DeviceCapability],
    bridgeStatus: String,
    hardwareInternalId: Int? = nil,
    controlConfiguration: DeviceControlConfiguration = .none,
    controlState: DeviceControlState = DeviceControlState()
  ) {
    self.id = id
    self.name = name
    self.productId = productId
    self.connection = connection
    self.capabilities = capabilities
    self.bridgeStatus = bridgeStatus
    self.hardwareInternalId = hardwareInternalId
    self.controlConfiguration = controlConfiguration
    self.controlState = controlState
  }
}
