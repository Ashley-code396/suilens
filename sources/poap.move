module suilens::poap;

use std::string::String;


public struct POAP has key{
        id: UID,
        event_name: String,
        event_date: u64,
        description: String,
        

}



public fun batch_mint_and_transfer(
    //_organizer_cap: &OrganizerCap,
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


