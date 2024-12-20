## tutorial
https://cloud.google.com/nat/docs/gce-example?hl=ja

## 目標
- 外部 IP アドレスが設定されていない VM インスタンスを構成する
- Identity-Aware Proxy（IAP）トンネルを使って VM インスタンスに接続する
- サブネットで限定公開の Google アクセスを有効にする
- Cloud NAT ゲートウェイを構成する
- Google API およびサービスのパブリック IP アドレスへのアクセスと、その他のインターネット接続を検証する

## VPC構成
| 項目               | value                                       |
|--------------------|--------------------------------------------|
| VPC                | privatenet |
| サブネット         | privatesubnet |
| リージョン         | asia-northeast1 |
| IPアドレスレンジ   | 10.130.0.0/20 |

## FW構成
| 項目               | value                                       |
|--------------------|--------------------------------------------|
| 名前               | privatenet-allow-ssh                       |
| ネットワーク       | privatenet                                 |
| ターゲット         | ネットワーク上のすべてのインスタンス     |
| ソースフィルタ     | IPv4 範囲                                 |
| 送信元 IPv4 範囲   | 35.235.240.0/20                           |
| プロトコルとポート | 指定したプロトコルとポート               |

## VMインスタンス構成
| プロパティ         | 値（値を入力するか、指定されたオプションを選択） |
|--------------------|--------------------------------------------|
| 名前               | vm-internal                                |
| リージョン         | asia-northeast1                             |
| ゾーン             | asia-northeast1a                           |
| シリーズ           | E2                                         |
| マシンタイプ       | e2-medium（2 vCPU、1 コア、4 GB メモリ） |
| ブートディスク     | debian-cloud/debian-9           |

## Cloud Storage構成

## Cloud NAT構成

## 作業
