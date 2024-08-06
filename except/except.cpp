#include <iostream>
int main(){
    try{
        throw 20;
    }
    catch(int e){
        std::cout << "Exception number " << e << '\n';
    }
    return 0;
}