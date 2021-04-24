class c_146_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_146_2;
    c_146_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xz010xx100z0x101x00z0xz11zz1xzxzzxxzxzzxxxxxxzzzzzxzxzzxxzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
