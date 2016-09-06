module FlashHelper
  FLASH_CLASSES = {
    notice: 'success',
    error: 'danger',
    alert: 'info'
  }.freeze

  def flash_class(flash_type)
    FLASH_CLASSES[flash_type.to_sym] || (raise "No flash class for #{flash_type}")
  end
end
