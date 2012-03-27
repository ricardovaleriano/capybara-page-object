module CapybaraPageObject
  class Table < CapybaraPageObject::Base
    def rows(attr={})
      extract('tr', attr)
    end

    def headers(attr={})
      extract('th', attr)
    end
  end
end