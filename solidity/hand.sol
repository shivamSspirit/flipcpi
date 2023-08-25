import "solana";

// Interface to the lever program.
leverInterface constant leverProgram = leverInterface(address'J5J3mD4ABcRtB7YcgrJBgugiQAP3DfcZi5bSAdiMAZWh');
interface leverInterface {
    function switchPower(string name) external;
}

@program_id("7zJ7E8uZccmCH89eykH8yZsB6G685nbz7sSq8N9sZTtq")
contract hand {

    // Creating a data account is required by Solang, but the account is not used in this example.
    // We only interact with the lever program.
    @payer(payer) // payer for the data account
    constructor() {}

    // "Pull the lever" by calling the switchPower instruction on the lever program via a Cross Program Invocation.
    function pullLever(address dataAccount, string name) public {
        // The account required by the switchPower instruction.
        // This is the data account created by the lever program (not this program), which stores the state of the switch.
        AccountMeta[1] metas = [
            AccountMeta({pubkey: dataAccount, is_writable: true, is_signer: false})
        ];

        // The data required by the switchPower instruction.
        string instructionData = name;

        // Invoke the switchPower instruction on the lever program.
        leverProgram.switchPower{accounts: metas}(instructionData);
    }
}