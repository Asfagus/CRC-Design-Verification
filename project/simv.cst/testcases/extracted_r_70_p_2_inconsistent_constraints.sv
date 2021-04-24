class c_70_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_70_2;
    c_70_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zx1111xx0zxx1z011x110z001zx1zz0zzzxxzzxzxzxxzxxzzzzxxzzzxxxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
