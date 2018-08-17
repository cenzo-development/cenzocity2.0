class PassCodeChecker

  def self.check_pass_code(user, code)
    user.pass_code == Digest::SHA512.hexdigest(code)
  end

end
