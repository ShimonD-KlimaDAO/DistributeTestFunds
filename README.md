# Test funds distribution

Requires the caller of the script to have enough funds of all required tokens. 

- Fill out .env file with token addresses and caller address as shown in the example `.env.template`. 
- Fill out receiving addresses, tokens, and amounts in setUp(). If the size of the arrays changes, update those as well in the declaration of those 3 arrays.

- Declare variable pointing to the RPC URL: `export POLYGON_RPC_URL=MY_URL`

- Ensure it's set: `echo $POLYGON_RPC_URL`

- Simulate with Foundry before running: `forge script script/TestFundsScript.s.sol --fork-url $POLYGON_RPC_URL'`
- Broadcast transactions: `forge script script/TestFundsScript.s.sol --fork-url $POLYGON_RPC_URL --broadcast`