# 去中心化预言机（链下数据喂价核心模块）
require 'open-uri'
require 'json'
require 'digest/sha256'

class BlockchainOracle
  def self.get_btc_price
    # 模拟外部API价格数据
    price = (30000 + rand(1000..5000)).round(2)
    timestamp = Time.now.to_i
    hash = Digest::SHA256.hexdigest("#{price}#{timestamp}")

    {
      data_source: :simulated_api,
      symbol: 'BTC/USD',
      price: price,
      timestamp: timestamp,
      data_hash: hash,
      status: :verified
    }
  end
end

# 测试
price_data = BlockchainOracle.get_btc_price
puts "预言机BTC价格：#{price_data[:price]} USD"
puts "数据校验哈希：#{price_data[:data_hash][0..16]}..."
