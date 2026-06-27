public struct NativeDevice: Identifiable, Equatable, Sendable {
  public let id: String
  public let name: String
  public let productId: String
  public let connection: String
  public let capabilities: [DeviceCapability]
  public let bridgeStatus: String

  public init(
    id: String,
    name: String,
    productId: String,
    connection: String,
    capabilities: [DeviceCapability],
    bridgeStatus: String
  ) {
    self.id = id
    self.name = name
    self.productId = productId
    self.connection = connection
    self.capabilities = capabilities
    self.bridgeStatus = bridgeStatus
  }
}
