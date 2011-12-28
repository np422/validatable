class Object #:nodoc:
  module InstanceExecHelper #:nodoc:
  end
  include InstanceExecHelper
  def instance_eval_with_params(*args, &block)
    n = 0
    n += 1 while respond_to?(mname="__instance_exec#{n}")
    InstanceExecHelper.module_eval{ define_method(mname, &block) }
    begin
      ret = send(mname, *args)
    ensure
      InstanceExecHelper.module_eval{ remove_method(mname) } rescue nil
    end
    ret
  end
end
