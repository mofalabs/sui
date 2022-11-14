
class RpcApiVersion {
  int major;
  int minor;
  int patch;

  RpcApiVersion(this.major, this.minor, this.patch);
}

RpcApiVersion parseVersionFromString(
  String version
) {
  final versions = version.split('.');
  return RpcApiVersion(
    int.parse(versions[0]), 
    int.parse(versions[1]), 
    int.parse(versions[2])
  );
}
