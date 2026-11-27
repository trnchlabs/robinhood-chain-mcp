# Robinhood Chain MCP server: rug checker and trading

**Robinhood Chain MCP server for AI agents: rug checker, wallet scan, alerts, Earn and best-route swaps.** Powered by [TRNCH](https://trnch.fun), a non-custodial trading terminal for Robinhood Chain (chainId 4663).

- **Rug checker, no key**: `trnch_check` returns whether any Robinhood Chain token is kept out by Trnch and its public risk category. Every decision is public at <https://trnch.fun/tia>.
- **Wallet scan, no key**: `trnch_scan_wallet` checks everything a wallet holds.
- **New launches, live**: the Heat lists new Robinhood Chain tokens a few seconds after their pool is created, screened by Trnch.
- **Alerts and Earn**: a webhook when a held token is flagged, and USDG lending on Morpho markets (variable rates, liquidation applies).
- **Best route**: each swap is quoted across eight routers (KyberSwap, LI.FI, Uniswap, 0x, SushiSwap, 1inch, Velora, Nordstern).
- **Non-custodial**: the server returns a transaction, your agent's own wallet signs it. No funds or keys are ever held.

## Connect

Remote server, streamable HTTP, nothing to install:

```
https://trnch.fun/api/mcp
```

Claude Desktop, Cursor, Windsurf, Cline or any MCP client with remote servers:

```json
{
  "mcpServers": {
    "robinhood-chain": {
      "url": "https://trnch.fun/api/mcp",
      "headers": { "Authorization": "Bearer trnch_bot_YOUR_KEY" }
    }
  }
}
```

Stdio-only client (Node 18+, no dependencies):

```json
{
  "mcpServers": {
    "robinhood-chain": {
      "command": "npx",
      "args": ["-y", "github:trnchlabs/robinhood-chain-mcp"],
      "env": { "TRNCH_API_KEY": "trnch_bot_YOUR_KEY" }
    }
  }
}
```

The free tools and the two `trnch_register` tools work without a key.

## Tools

| Tool | Key | What it does |
|---|---|---|
| `trnch_check` | no | Rug and honeypot check of any Robinhood Chain token: status, public risk category, copycat link |
| `trnch_scan_wallet` | no | Checks every ERC-20 a wallet holds in one call, flagged tokens first, with `canSell` and a sell hint |
| `trnch_top_24h` | no | Best tokens that entered the Heat in the last 24 hours |
| `trnch_stats` | no | Live public numbers for the last 24 hours |
| `trnch_quote` | no | Quote a pair across eight routers, net of the Trnch fee |
| `earn_markets` | no | Morpho markets lending USDG on Robinhood Chain, and the USDG vaults when open |
| `earn_position` | no | Earn positions of a wallet, read on chain |
| `earn_quote` | no | Summary of a borrow, a deposit or a Multiply before building it |
| `trnch_register_message` | no | Message your wallet signs to get a key |
| `trnch_register` | no | Sends the signature, returns the key (shown once) |
| `trnch_heat` | yes | The live Heat: screened tokens as opaque ids with market numbers, plus newly spotted ones |
| `trnch_buy` | yes | Build a buy (`tokenId` or `token`, `amountUsd` paid in USDG): returns the transaction to sign |
| `trnch_sell` | yes | Build a sell for USDG, by `percent` or `amount` |
| `trnch_confirm` | yes | Optional: report the tx hash so the volume counts for your Trnch account |
| `trnch_alerts_subscribe` | yes | Signed webhook when a token a wallet holds is newly flagged |
| `trnch_alerts_list` | yes | List your alert subscriptions |
| `trnch_alerts_unsubscribe` | yes | Remove an alert subscription |
| `earn_build` | yes | Build an Earn action (deposit, withdraw, borrow, repay, collateral, Multiply, vaults) for your wallet to sign |
| `trnch_partner_fee_get` | partner | Read a partner's default integrator fee |
| `trnch_partner_fee_set` | partner | Set it, 0 to 100 basis points |

Every trade and Earn call returns transactions for your wallet to sign. Nothing is sent by Trnch.

## Fees

Swaps through the MCP server and the Bot API: 0.25% standard, 0.10% between major assets, 0.05% between a Stock Token and a major asset, 0.50% for tokens under 24 h old or with no known launch time. The rate is returned as `feeBps` and is already deducted from quotes.

A Trnch partner can add an integrator fee (`integratorFeeBps`, 0 to 100 basis points, or its default fee with the `X-Trnch-Partner-Key` header). It is added to the Trnch fee and paid to the partner through the partner program once the swap is confirmed on chain.

## Get a key, no browser

1. `GET https://trnch.fun/api/bot/v1/register?wallet=0xYourWallet` returns `message`.
2. Sign `message` with that wallet (`personal_sign`). No funds move.
3. `POST https://trnch.fun/api/bot/v1/register` with `{ wallet, message, signature }` returns your `trnch_bot_...` key.

Up to 3 keys per wallet.

## Examples

- [`examples/agent.ts`](examples/agent.ts): key by signature, read the Heat, buy, sign and send.
- [`examples/stats.sh`](examples/stats.sh): live launch numbers, by REST and by MCP.

## Robinhood Chain reference

| | |
|---|---|
| Chain ID | 4663 |
| RPC | `https://rpc.mainnet.chain.robinhood.com` |
| USDG | `0x5fc5360D0400a0Fd4f2af552ADD042D716F1d168` |
| Explorer | [robinhoodchain.blockscout.com](https://robinhoodchain.blockscout.com) |

## Agent builders

Shipping an agent to others? Set your TRNCH referral code (`ref`): every swap made with a key it creates pays you 25% of the TRNCH fee, for life.

Framework integrations (ElizaOS, GOAT, Coinbase AgentKit) are in [trnchlabs/trnch-mcp](https://github.com/trnchlabs/trnch-mcp/tree/main/integrations).

## Links

- Agents: <https://trnch.fun/agents>
- Docs: <https://docs.trnch.fun>
- Contracts: <https://github.com/trnchlabs/trnch-contracts>
- Bot API docs: <https://trnch.fun/bot>
- Agent guide: <https://trnch.fun/skill.md>
- OpenAPI: <https://trnch.fun/openapi.json>
- Official MCP registry: `fun.trnch/trnch`
- Terms: <https://docs.trnch.fun/legal/terms>. TRNCH data is licensed for trading through TRNCH only.

TRNCH is an independent app built on Robinhood Chain, not affiliated with Robinhood Markets, Inc. TRNCH has no token.
