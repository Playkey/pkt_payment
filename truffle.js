module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "localhost",
      port: 8546,
      network_id: "37549"
    },
    ropsten: {
      host: "localhost",
      port: 8545,
      network_id: "3"
    },
    office: {
      host: "localhost",
      port: 8545,
      network_id: "555"
    },
  }
};
