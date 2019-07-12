class UserStatsPdf < Prawn::Document
  def initialize(user,stats)
    super()
    @user = user
    @stats = stats
    render
  end

  def render
    text "User Statistics", size: 30
    text "Basic Information", size: 20
    basic_info = make_table user_info, cell_style: {borders: []}
    img = (@user.avatar.attached?)? rails_blob_url(@user.avatar) : "app/assets/default_profile_img.jpg"
    table([[basic_info, {image: img, fit: [130, 130], position: :center}]], 
      column_widths: {0=>590, 1 => 150}, 
      cell_style: {borders: []}
    )
    pad(20){text "General Stats", size: 20}
    g = Gruff::Bar.new('700x300')
    g.theme = current_theme
    @stats[:general_stats].each{|k,v| g.data(k, v)}
    g.show_labels_for_bar_values = true
    g.legend_font_size = 18
    g.label_formatting = '%.0f'
    image StringIO.new(g.to_blob), scale: 0.55, position: :center
    
    text "Reactions", size: 20
    g = Gruff::Pie.new(700)
    g.theme = current_theme
    if @stats[:general_stats][:reactions_count] > 0
      @stats[:reactions_stats].each{|k,v| g.data(k, v) } 
    end
    g.legend_font_size = 18
    g.no_data_message = "You're boring!"
    image StringIO.new(g.to_blob), scale: 0.55, position: :center
    if @stats[:general_stats][:reactions_count] > 100
      text "If I were given a coin for each reaction you've made, I'll be poor (but not that poor!)", size: 10
    else
      text "If I were given a coin for each reaction you've made, I'll surely be poor", size: 10
    end
  end

  def user_info
    [["Handle:", @user.handle],
      ["Email:", @user.email],
      ["Birthday:",@user.birthday],
      ["Password:", "just kiddin' (unless you suck at setting up passwords!)"]]
  end

  def current_theme
    {
      :colors => ['#FDD84E','#6886B4','#72AE6E','#D1695E','#8A6EAF', '#EFAA43','gray'],
      :marker_color => 'gray',
      :font_color => 'black',
      :background_colors => 'white'
    }
  end
end