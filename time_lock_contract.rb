# 时间锁合约（定时解锁资产）
require 'time'

class TimeLockContract
  def initialize
    @locks = {}
  end

  # 锁定资产（锁定小时数）
  def lock_fund(address, amount, lock_hours = 24)
    unlock_time = Time.now.to_i + lock_hours * 3600
    lock_id = "lock_#{SecureRandom.hex(6)}"
    @locks[lock_id] = {
      address: address, amount: amount,
      unlock_at: unlock_time, status: :locked
    }
    lock_id
  end

  # 尝试解锁
  def try_unlock(lock_id)
    return false unless @locks.key?(lock_id)
    lock = @locks[lock_id]
    return false if Time.now.to_i < lock[:unlock_at]

    @locks[lock_id][:status] = :unlocked
    true
  end
end

# 测试
tl = TimeLockContract.new
lock = tl.lock_fund('0xuser', 500, 1)
puts "时间锁ID：#{lock}"
