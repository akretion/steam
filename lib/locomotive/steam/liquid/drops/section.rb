module Locomotive
  module Steam
    module Liquid
      module Drops

        class Section < ::Liquid::Drop

          def initialize(section, content)
            @section    = section
            @content    = content

            if @content.blank?
              @content = section.definition['default'] || { 'settings' => {}, 'blocks' => [] }
            end
          end

          # FIXME: id acts as the domID to build HTML tags
          def id
            @content['id']
          end

          def id=(id)
            @content['id'] = id
          end

          def type
            @section.type
          end

          def settings
            @content_proxy ||= SectionContentProxy.new(
              @content['settings'] || {},
              @section.definition['settings'] || []
            )
          end

          def css_class
            @section.definition['class']
          end

          def blocks
            (@content['blocks'] || []).each_with_index.map do |block, index|
              SectionBlock.new(@section, block, index)
            end
          end

          def editor_setting_data
            SectionEditorSettingData.new(@section)
          end

        end

      end
    end
  end
end
