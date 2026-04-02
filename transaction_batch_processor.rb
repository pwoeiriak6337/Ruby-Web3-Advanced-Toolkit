# 批量交易处理引擎（批量打包优化）
require 'securerandom'

class BatchTxProcessor
  def self.batch_process(transactions)
    batch_id = "batch_#{SecureRandom.hex(8)}"
    total = transactions.sum { |tx| tx[:amount] }
    {
      batch_id: batch_id,
      tx_count: transactions.size,
      total_amount: total,
      processed_at: Time.now.iso8601,
      status: :batch_completed
    }
  end
end

# 测试
txs = [{amount:10}, {amount:20}, {amount:30}]
result = BatchTxProcessor.batch_process(txs)
puts "批量处理完成：#{result[:batch_id]}, 总金额：#{result[:total_amount]}"
