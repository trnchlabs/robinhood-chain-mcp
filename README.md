# Robinhood Chain MCP server: rug checker and trading

**Trade new Robinhood Chain tokens and memecoins from any AI agent, with rug and honeypot checks and the best DEX route.** Powered by [TRNCH](https://trnch.fun), a non-custodial trading terminal for Robinhood Chain (chainId 4663).

- **Rug checker, no key**: `trnch_check` returns whether any Robinhood Chain token is kept out by TIA (rug, honeypot, scam contract, heavy sell tax, copycat, dump) and its public risk category. Every decision is public at <https://trnch.fun/tia>.
- **New launches, live**: the Heat lists new Robinhood Chain tokens a few seconds after their pool is created.
- **Rug and honeypot checks**: every launch is screened by TIA (Trnch Intelligence Agency). Rugs, honeypots, scam contracts, heavy sell taxes and copycats are kept out, and the API refuses to trade them.
- **Best route**: each swap is quoted across six routers (KyberSwap, LI.FI, Uniswap, 0x, SushiSwap, 1inch).
- **Non-custodial**: the server returns a transaction, your agent's own wallet signs it. No funds or keys are ever held.
- **0.5% per swap**, already deducted from every quote.

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
      "args": ["-y", "github:isonips/robinhood-chain-mcp"],
      "env": { "TRNCH_API_KEY": "trnch_bot_YOUR_KEY" }
    }
  }
}
```

`trnch_check`, `trnch_stats` and the two `trnch_register` tools work without a key.

## Tools

| Tool | What it does |
|---|---|
| `trnch_check` | Is this Robinhood Chain token a rug? TIA verdict and public risk category for any token address (no key) |
| `trnch_stats` | Live numbers over 24 hours: tokens spotted, kept out as High risk, rugs detected, median detection delay |
| `trnch_register_message` | Message your wallet signs to get an API key |
| `trnch_register` | Sends the signature, returns the key (shown once) |
| `trnch_heat` | New Robinhood Chain tokens, screened and ranked live |
| `trnch_quote` | Quote a swap across six routers |
| `trnch_buy` | Buy a token with USDG, returns the transaction to sign |
| `trnch_sell` | Sell a token for USDG, by percent or amount |
| `trnch_confirm` | Optional: report the tx hash |

## Get a key, no browser

1. `GET https://trnch.fun/api/bot/v1/register?wallet=0xYourWallet` returns `message`.
2. Sign `message` with that wallet (`personal_sign`). No funds move.
3. `POST https://trnch.fun/api/bot/v1/register` with `{ wallet, message, signature }` returns your `trnch_bot_...` key.

The wallet needs 10 USDG or 0.004 ETH on Robinhood Chain.

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

Framework integrations (ElizaOS, GOAT, Coinbase AgentKit) are in [isonips/trnch-mcp](https://github.com/isonips/trnch-mcp/tree/main/integrations).

## Links

- Bot API docs: <https://trnch.fun/bot>
- Agent guide: <https://trnch.fun/skill.md>
- OpenAPI: <https://trnch.fun/openapi.json>
- Official MCP registry: `fun.trnch/trnch`
- Terms: <https://docs.trnch.fun/legal/terms>. TRNCH data is licensed for trading through TRNCH only.

TRNCH is an independent app built on Robinhood Chain, not affiliated with Robinhood Markets, Inc. TRNCH has no token.
