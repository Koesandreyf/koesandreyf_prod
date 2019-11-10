class Turbolyapp < ApplicationRecord
  validates :title, presence: true, length: {maximum: 50} 

  def self.check_data(data)
    title = data[:title]
    text = data[:text]
    date = data[:date]
    get_same_todo = Turbolyapp.where(:title => title, :text => text, :date => date)

    if get_same_todo.present?
      return false
    end

    return true
  end

  def self.check_date(data)
    get_all_date = data.map{|get_date| get_date.date}
    get_current_time = Date.today
    same_date = []

    if get_all_date.include? get_current_time
      data.each do |get_date|
        if get_date.date == get_current_time
          same_date << get_date
        end
      end
    end
    return same_date
  end
end
