# mattsu-coin
- トークンの勉強用。実用性は一切無し
- ERC-20準拠のトークンをOpenZeppelinベースで実装
- 下記を参考にした
  - https://docs.openzeppelin.com/contracts/3.x/erc20
  
## チュートリアル
### truffle develop環境
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
