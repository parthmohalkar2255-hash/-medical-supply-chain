module MedicalChain::SupplyChain {

    use aptos_framework::signer;

    /// Struct representing a shipment of medical supplies
    struct Shipment has store, key {
        id: u64,
        description: vector<u8>,
        delivered: bool,
    }

    /// Function to register a new shipment
    public fun register_shipment(sender: &signer, id: u64, description: vector<u8>) {
        let shipment = Shipment {
            id,
            description,
            delivered: false,
        };
        move_to(sender, shipment);
    }

    /// Function to confirm the delivery of a shipment
    public fun confirm_delivery(receiver: &signer, sender_address: address) acquires Shipment {
        let shipment = borrow_global_mut<Shipment>(sender_address);
        assert!(!shipment.delivered, 1); // already delivered
        shipment.delivered = true;
    }
}
