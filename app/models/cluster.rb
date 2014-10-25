class Cluster < ActiveRecord::Base
    
    STATUS_PENDING = 0
    STATUS_OK = 1
    
    def status_ok?
        self[:status] == STATUS_OK
    end
end
