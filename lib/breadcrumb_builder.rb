# frozen_string_literal: true

class BreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::SimpleBuilder
  # This builder class follows the API at:
  # https://github.com/weppos/breadcrumbs_on_rails/blob/master/lib/breadcrumbs_on_rails/breadcrumbs.rb

  def render
    @context.tag.nav(aria: { label: 'breadcrumb' }, class: 'd-inline-block') do
      @context.tag.ol(class: 'breadcrumb') do
        @context.safe_join(@elements.map do |element|
          render_element(element)
        end)
      end
    end
  end

  def render_element(element)
    content = if element.path.nil?
                compute_name(element)
              else
                @context.link_to_unless_current(
                  compute_name(element),
                  compute_path(element),
                  element.options
                )
              end
    @context.tag.li(content, class: 'breadcrumb-item')
  end
end
