module TrainsHelper
  def chart_prepared?(s_time)
    s_time.in_time_zone('Asia/Kolkata') < (Time.now + 12.hours).in_time_zone('Asia/Kolkata')
  end

  def train_departured?(s_time)
    s_time.in_time_zone('Asia/Kolkata') < Time.now.in_time_zone('Asia/Kolkata')
  end
end
