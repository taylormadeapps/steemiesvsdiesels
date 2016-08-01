# steemiesvsdiesels
Docker container for Steem, with built in SSH server for easy maintenance and configuration.
This has been built form source using steps outlined in "Steem Mining for Dummies": https://steemit.com/steemhelp/@joseph/mining-steem-for-dummies.

Note: Be sure to change the public key in /root/.ssh/authorized_keys
Also be sure to update the Steem config.ini file in /root/steem/programs/steemd/witness_node_data_dir/config.ini with your Steemid and private WIF key.
