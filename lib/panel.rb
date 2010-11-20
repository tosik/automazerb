module Automaze
  class Panel
    def initialize(kind)
      set_kind(kind)
    end

    PANEL_KINDS = [:floor, :wall]

    def kind_valid?(kind)
      PANEL_KINDS.include? kind
    end

    PANEL_KINDS.each do |kind|
      define_method("#{kind}?") do
        @kind == kind
      end
    end

    def set_kind(kind)
      raise "unknown kind" unless kind_valid?(kind)
      @kind = kind
    end

  end
end
