class c_59_2;
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

program p_59_2;
    c_59_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1zx0z0111xx11xz100z0110zx1xz0xzzxxzzzzzzxzzxzzxzzzxxzxxxzxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
