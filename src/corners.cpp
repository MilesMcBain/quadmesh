#include <Rcpp.h>
using namespace Rcpp;

//' Corner coordinates
//'
//' @param x coordinates
//' @param y coordinates
//' @return character vector of layer names
//'
//' @export
// [[Rcpp::export]]
List corners_cpp(NumericVector x, NumericVector y) {

  List out(3);



  CharacterVector names(3);
  names[0] = "x";
  names[1] = "y";
  names[2] = "quad";
  out.attr("names") = names;
  return out;
}

//tools::package_native_routine_registration_skeleton("../quadmesh", "src/init.c",character_only = FALSE)
