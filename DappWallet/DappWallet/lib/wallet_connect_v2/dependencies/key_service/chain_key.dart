class ChainKey {
  final List<String> chains;
   String privateKey;
   String publicKey;

  ChainKey({
    required this.chains,
    required this.privateKey,
    required this.publicKey,
  });

  @override
  String toString() {
    return 'ChainKey(chains: $chains, privateKey: $privateKey, publicKey: $publicKey)';
  }
}
