class PassCodeGenerator

  def self.generate_passcode(user_id)
    cell_phone_number = ""
    user = User.find(user_id)
    if !user.nil?
      cell_phone_number = Utilities.sanitize_cell_phone_number( user.mobile_phone)

      #create passcode
      o = [(0..9)].map { |i| i.to_a }.flatten
      pass_code = (0...6).map { o[rand(o.length)] }.join
    end
  end

end
