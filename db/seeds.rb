(1..101).each do |number|
  Task.create(status: 'status ' + number.to_s, content: 'content ' + number.to_s)
end