SimpleCov.start do
  add_filter 'spec'

  add_group 'DCP' do |src_file| 
    File.basename(src_file.filename).match /^dcp/
  end
  add_group 'Frames', 'lib/dcp/frames'
  add_group 'Blocks', 'lib/dcp/blocks'
  add_group 'Core extensions', 'lib/dcp/ext'
end
