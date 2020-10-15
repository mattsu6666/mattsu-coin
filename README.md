# mattsu-coin
- トークンの勉強用。実用性は一切無し
- ERC-20準拠のトークンをOpenZeppelinベースで実装
- ChainlinkのAPIも使ってみた
- 下記を参考にした
  - https://docs.openzeppelin.com/contracts/3.x/erc20
  - https://docs.chain.link/docs/using-chainlink-reference-contracts
  
## チュートリアル
### truffle develop環境
- ビルド & デプロイ

```
$ npm install
$ truffle develop
truffle(develop)> migrate
```

- mint & burn

```
truffle(develop)> let a = await MattsuCoin.deployed()
truffle(develop)> a.balanceOf(accounts[1]).then(v => v.toString())
'0'
truffle(develop)> a.mint(accounts[1], 1000)
...
truffle(develop)> a.balanceOf(accounts[1]).then(v => v.toString())
'1000'
truffle(develop)> a.burn(accounts[1], 100)
...
truffle(develop)> a.balanceOf(accounts[1]).then(v => v.toString())
'900'
```

- AccessControlの動作確認

```
// 権限を持ってないアカウントが勝手にお金を増やそうとすると、エラーになる
truffle(develop)> a.mint(accounts[1], 1000, {from: accounts[1]})
Uncaught:
Error: Returned error: VM Exception while processing transaction: revert You are not admin -- Reason given: You are not admin.
```

- Eth残高のチェック
```
truffle(develop)> web3.eth.getBalance(accounts[0])
```

### Kovanテストネットワーク環境
Infura経由でKovanに接続するので、予めInfuraでプロジェクトを作っておくこと。また、接続予定のアカウントにイーサを入金しておくこと

- ビルド & デプロイ

```
$ npm install
$ cp .env.sample .env
$ vim .env // 適宜
$ truffle console --network kovan
truffle(kovan)>  migrate
```

- オラクルを使ったトランザクション
  - BuyEthUsdを捕捉して、ETH/USDのレートを得られた (得られた値の単位は謎...1セント辺りのgwei??)
```
truffle(kovan)> let b = await MattsuCoin.deployed()
...
truffle(kovan)> b.buyLatestEthUsd().then(res => console.log(res.logs[1].event, res.logs[1].args[1].toString(10)))
BuyEthUsd 39217000000
undefined
```

## 今後
OpenZeppelinをベースに作ると、あまりにも実装することがなさすぎるので、依存せずに開発してみたい
