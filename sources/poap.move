module suilens::poap;

use std::string::String;


public struct POAP has key{
        id: UID,
        event_name: String,
        event_date: u64,
        description: String,
        

}

public struct OrganizerCap has key, store{
        id: UID

}


//Register as organiser function
#[allow(lint(self_transfer))]
public fun register_as_organiser(ctx: &mut TxContext){

        let organizer_cap = OrganizerCap{
        id: object::new(ctx)

    };

    transfer::public_transfer(organizer_cap, ctx.sender())

}


//Mint and transfer POAP(organiserv only function)


public fun batch_mint_and_transfer(
    _organizer_cap: &OrganizerCap,
    event_name: String,
    event_date: u64,
    description: String,
    recipients: vector<address>,
    ctx: &mut TxContext
) {
    let n = vector::length(&recipients);
    let mut i = 0;
    while (i < n) {
        let poap = POAP {
            id: object::new(ctx),
            event_name,
            event_date,
            description,
        };
        transfer::transfer(poap, *vector::borrow(&recipients, i));
        i = i + 1;
    }
}


