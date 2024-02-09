using Org.BouncyCastle.Crypto.Digests;

namespace SymbolSdk.Nem
{
    /**
     * Represents a NEM network timestamp with millisecond resolution.
     */
    public class NetworkTimestamp : BaseNetworkTimestamp
    {
        public NetworkTimestamp(ulong timestamp) : base(timestamp) { }

        /**
	     * Adds a specified number of seconds to this timestamp.
	     * @override
	     * @param {ulong} count Number of seconds to add.
	     * @returns {NetworkTimestamp} New timestamp that is the specified number of seconds past this timestamp.
	     */
        public override BaseNetworkTimestamp AddSeconds(ulong count)
        {
            return new NetworkTimestamp(Timestamp + count);
        }
    }

    /**
     * Represents a NEM network.
     */
    public class Network : BaseNetwork<Address>
    {
        private Hash256? GenerationHashSeed { get; }

        public static readonly Network MainNet = new Network(
            "mainnet",
            0x68,
            new DateTime(2015, 3, 29, 0, 6, 25, DateTimeKind.Utc)
        );
        public static readonly Network TestNet = new Network(
            "testnet",
            0x98,
            new DateTime(2015, 3, 29, 0, 6, 25, DateTimeKind.Utc)
        );

        /**
	     * Creates a new network with the specified name, identifier byte and generation hash seed.
	     * @param {string} name Network name.
	     * @param {byte} identifier Network identifier byte.
	     * @param {DateTime} epochTime Network epoch time.
	     */
        private Network(string name, byte identifier, DateTime epochTime, Hash256? generationHashSeed = null) : base(
            name,
            identifier,
            new NetworkTimestampDatetimeConverter(epochTime, "seconds"),
            new KeccakDigest(256),
            CreateAddressFunc,
            typeof(NetworkTimestamp)
        )
        {
            GenerationHashSeed = generationHashSeed;
        }

        private static Address CreateAddressFunc(byte[] addressWithoutChecksum, byte[] checksum)
        {
            var newBytes = new byte[addressWithoutChecksum.Length + checksum.Length];
            addressWithoutChecksum.CopyTo(newBytes, 0);
            checksum.CopyTo(newBytes, addressWithoutChecksum.Length);
            return new Address(newBytes);
        }
    }
}