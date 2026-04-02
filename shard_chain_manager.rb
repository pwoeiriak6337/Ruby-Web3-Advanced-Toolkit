# 区块链分片管理（水平扩容核心）
require 'securerandom'

class ShardManager
  def initialize(shard_count = 4)
    @shards = Array.new(shard_count) { |i| "shard_#{i+1}" }
    @shard_transactions = Hash.new { |h, k| h[k] = [] }
  end

  # 分配交易到分片
  def assign_to_shard(address, tx_data)
    shard_id = @shards[address.hash % @shards.size]
    @shard_transactions[shard_id] << {
      tx: SecureRandom.hex(8), data: tx_data, assigned_at: Time.now.to_i
    }
    shard_id
  end

  # 获取分片状态
  def shard_stats
    @shard_transactions.transform_values(&:size)
  end
end

# 测试
shard = ShardManager.new
sid = shard.assign_to_shard('0xuser123', 'transfer 10 RUBY')
puts "交易分配至分片：#{sid}"
puts "分片交易量：#{shard.shard_stats}"
