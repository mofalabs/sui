
const SUI_NS_NAME_REGEX =
	r"^(?!.*--)(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?(?:\.[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?)*)?@[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?$";
const SUI_NS_DOMAIN_REGEX = r"^(?!.*--)(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+sui$";
const MAX_SUI_NS_NAME_LENGTH = 235;

enum SuiNSType {
  at, dot
}

bool isValidSuiNSName(String name) {
	if (name.length > MAX_SUI_NS_NAME_LENGTH) {
		return false;
	}

	if (name.contains("@")) {
    return RegExp(SUI_NS_NAME_REGEX, caseSensitive: false).hasMatch(name);
	}

  return RegExp(SUI_NS_DOMAIN_REGEX, caseSensitive: false).hasMatch(name);
}

String normalizeSuiNSName(String name, [SuiNSType format = SuiNSType.at]) {
	final lowerCase = name.toLowerCase();
	List<String> parts;

	if (lowerCase.contains("@")) {
		if (!RegExp(SUI_NS_NAME_REGEX, caseSensitive: false).hasMatch(lowerCase)) {
			throw ArgumentError("Invalid SuiNS name $name");
		}
		final [labels, domain] = lowerCase.split('@');
		parts = [...(labels.isNotEmpty ? labels.split('.') : []), domain];
	} else {
		if (!RegExp(SUI_NS_DOMAIN_REGEX, caseSensitive: false).hasMatch(lowerCase)) {
			throw ArgumentError("Invalid SuiNS name $name");
		}
    final tmp = lowerCase.split('.');
		parts = tmp.sublist(0, tmp.length - 1);
	}

	if (format == SuiNSType.dot) {
		return "${parts.join('.')}.sui";
	}

	return "${parts.sublist(0, parts.length - 1).join('.')}@${parts[parts.length - 1]}";
}
