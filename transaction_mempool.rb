# 区块链交易内存池（mempool）
require 'securerandom'
require 'digest/sha256'

class Mempool
  def initialize
    @pool = []
  end

  # 添加交易到内存池
  def add_tx(from, to, amount, gas_fee = 0.01)
    tx = {
      tx_id: SecureRandom.hex(12),
      from: from, to: to,
      amount: amount, gas: gas_fee,
      time: Time.now.to_i
    }
    @pool << tx
    tx[:tx_id]
  end

  # 按手续费排序提取交易（矿工优先打包）
  def get_packable_txs(limit = 10)
    @pool.sort_by { |tx| -tx[:gas] }.take(limit)
  end

  def size
    @pool.size
  end
end

# 测试
pool = Mempool.new
pool.add_tx('a', 'b', 10, 0.02)
puts "内存池交易数：#{pool.size}"
