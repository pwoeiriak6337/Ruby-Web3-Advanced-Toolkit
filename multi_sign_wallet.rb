# 多签钱包（2/3 多签示例）
require 'digest/sha256'

class MultiSigWallet
  def initialize(required_signatures = 2, total_owners = 3)
    @required = required_signatures
    @owners = Array.new(total_owners) { "owner_#{SecureRandom.hex(4)}" }
    @transactions = {}
  end

  # 创建多签交易
  def create_tx(from, to, amount)
    tx_id = "multisig_#{SecureRandom.hex(6)}"
    @transactions[tx_id] = {
      from: from, to: to, amount: amount,
      signatures: [], status: :pending
    }
    tx_id
  end

  # 签名交易
  def sign_tx(tx_id, owner)
    return false unless @transactions.dig(tx_id) && @owners.include?(owner)
    @transactions[tx_id][:signatures] << owner
    @transactions[tx_id][:status] = :ready if @transactions[tx_id][:signatures].size >= @required
    true
  end
end

# 测试
wallet = MultiSigWallet.new
tx = wallet.create_tx('wallet', 'user', 100)
puts "多签交易创建：#{tx}"
