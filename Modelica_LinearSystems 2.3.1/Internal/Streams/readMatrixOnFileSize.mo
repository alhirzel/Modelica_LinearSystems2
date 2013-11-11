within Modelica_LinearSystems2.Internal.Streams;
function readMatrixOnFileSize "Read size of matrix matrixName from file"
  input String fileName "File name";
  input String matrixName "Matrix name";
  output Integer dim[2] "Size of matrix matrixName";
external "C" readMatrixSizeEx(
    fileName,
    matrixName,
    dim);
  annotation (Include="

#include <matrixop.h>

void readMatrixSizeEx(const char *file, const char *matname, int* dim)
{
  IntegerArray ms;
  ms=readMatrixSize(file,matname);
  dim[0]=ms.data[0];
  dim[1]=ms.data[1];
  return;
}");
end readMatrixOnFileSize;
