class UserCertificatePdf < Prawn::Document
  def initialize(user)
    @user = user
    super(:background => "app/assets/images/certificate-background.png",
      :page_size => [971,672]
    )
    font_families.update("Dancing_Script" => {
      :normal => "app/assets/fonts/Dancing_Script/DancingScript-Regular.ttf",
      :bold => "app/assets/fonts/Dancing_Script/DancingScript-Bold.ttf"
    })
    font_families.update("Baskerville" => {
      :normal => "app/assets/fonts/Libre_Baskerville/LibreBaskerville-Regular.ttf",
      :bold => "app/assets/fonts/Libre_Baskerville/LibreBaskerville-Bold.ttf",
      :italic => "app/assets/fonts/Libre_Baskerville/LibreBaskerville-RegularItalic.ttf"
    })
    certificate_pdf
  end

  def certificate_pdf
    move_down 55
    image "app/assets/images/meme-logo.jpeg", scale: 0.75,position: :center
    move_down 30
    font "Baskerville" do
      text "Elon Duck produly gives you", size: 20, align: :center
    end
    move_down 10
    font "Dancing_Script" do
      text @user.handle, size: 70, align: :center
    end
    font "Baskerville" do
      text @user.email, size: 15, align: :center
      move_down 25
      text "the title of ", size: 20, align: :center
    end
    font "Dancing_Script" do
      text @user.memer_degree, size: 70, align: :center
      text "Generated on #{Date.today.to_s}", size: 20,align: :center
    end
    image "/home/mah/Git/backendMe-Me/app/assets/images/seal.png", at: [700,200]
  end
end