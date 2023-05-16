module my_first_package::devnet_nft {
    use sui::url::{Self, Url};
    use std::string::{Self, String};
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// An example NFT that can be minted by anybody
    struct DevNetNFT has key, store {
        id: UID,
        /// Name for the token
        name: String,
        /// Description of the token
        description: String,
        /// URL for the token
        url: Url,
        // TODO: allow custom attributes
    }

    struct MintNFTEvent has copy, drop {
        object_id: ID,
        creator: address,
        name: String,
    }

    public entry fun mint(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext
    ) {
        let nft = DevNetNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };

        let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name
        });
        transfer::public_transfer(nft, sender);
    }

    public entry fun update_description(
        nft: &mut DevNetNFT,
        new_description: vector<u8>
    ) {
        nft.description = string::utf8(new_description);
    }

    public entry fun burn(nft: DevNetNFT) {
        let DevNetNFT { id, name: _, description: _, url: _} = nft;
        object::delete(id)
    }

    public fun name(nft: &DevNetNFT): &string::String {
        &nft.name
    }

    public fun description(nft: &DevNetNFT): &string::String {
        &nft.description
    }

    public fun url(nft: &DevNetNFT): &Url {
        &nft.url
    }
}