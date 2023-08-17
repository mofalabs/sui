import 'dart:typed_data';

// See: sui/crates/sui-types/src/intent.rs
enum AppId {
	sui
}

enum IntentVersion {
	v0
}

enum IntentScope {
	transactionData,
	transactionEffects,
	checkpointSummary,
	personalMessage
}

Uint8List messageWithIntent(IntentScope scope, Uint8List message) {
	List<int> intent = [scope.index, IntentVersion.v0.index, AppId.sui.index];
	final intentMessage = Uint8List(intent.length + message.length);
  intentMessage.setAll(0, intent);
  intentMessage.setAll(intent.length, message);
	return intentMessage;
}
