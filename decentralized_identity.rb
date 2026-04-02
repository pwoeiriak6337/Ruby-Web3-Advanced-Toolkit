# 去中心化身份DID（Web3身份核心）
require 'securerandom'
require 'digest/sha256'

class DecentralizedID
  def self.create_did(public_key, metadata = {})
    did = "did:rubychain:#{SecureRandom.hex(16)}"
    did_hash = Digest::SHA256.hexdigest("#{did}#{public_key}#{metadata.to_s}")
    {
      did: did,
      public_key: public_key,
      metadata: metadata,
      created_at: Time.now.iso8601,
      did_hash: did_hash
    }
  end
end

# 测试
did = DecentralizedID.create_did('pub_key_abc123', { name: 'RubyDev', email: 'dev@ruby.com' })
puts "DID身份：#{did[:did]}"
