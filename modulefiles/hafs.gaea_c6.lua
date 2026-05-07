help([[
  This module loads libraries required for building and running HAFS
  on the NOAA RDHPC machine Gaea C6 using Intel-2023.2.0.
]])

whatis("Description: HAFS Application environment")

prepend_path("MODULEPATH", "/ncrc/proj/epic/spack-stack/c6/spack-stack-1.9.2/envs/ue-intel-2023.2.0/install/modulefiles/Core")

stack_intel_ver=os.getenv("stack_intel_ver") or "2023.2.0"
load(pathJoin("stack-intel", stack_intel_ver))

stack_cray_mpich_ver=os.getenv("stack_cray_mpich_ver") or "8.1.30"
load(pathJoin("stack-cray-mpich", stack_cray_mpich_ver))

stack_python_ver=os.getenv("stack_python_ver") or "3.11.7"
load(pathJoin("stack-python", stack_python_ver))

cmake_ver=os.getenv("cmake_ver") or "3.27.9"
load(pathJoin("cmake", cmake_ver))

local ufs_modules = {
  {["py-numpy"]        = "1.26.4"},
  {["py-xarray"]       = "2024.7.0"},
  {["py-netcdf4"]      = "1.7.1.post2"},
  {["jasper"]          = "2.0.32"},
  {["zlib"]            = "1.2.13"},
  {["libpng"]          = "1.6.37"},
  {["hdf5"]            = "1.14.3"},
  {["netcdf-c"]        = "4.9.2"},
  {["netcdf-fortran"]  = "4.6.1"},
  {["parallelio"]      = "2.6.2"},
  {["esmf"]            = "8.8.0"},
  {["fms"]             = "2024.02"},
  {["bacio"]           = "2.4.1"},
  {["crtm"]            = "2.4.0.1"},
  {["g2"]              = "3.5.1"},
  {["g2tmpl"]          = "1.13.0"},
  {["ip"]              = "5.1.0"},
  {["nemsio"]          = "2.5.4"},
  {["sp"]              = "2.5.0"},
  {["w3emc"]           = "2.10.0"},
  {["w3nco"]           = "2.4.1"},
  {["gftl-shared"]     = "1.9.0"},
-- no yafyaml
  {["mapl"]            = "2.53.4-esmf-8.8.0"},
  {["bufr"]            = "12.1.0"},
  {["sfcio"]           = "1.4.2"},
  {["sigio"]           = "2.3.3"},
-- no szip
  {["wrf-io"]          = "1.2.0"},
  {["prod_util"]       = "2.1.1"},
  {["grib-util"]       = "1.4.0"},
  {["wgrib2"]          = "3.6.0"},
-- no gempak
  {["nco"]             = "5.2.4"},
  {["cdo"]             = "2.3.0"},
}

for i = 1, #ufs_modules do
  for name, default_version in pairs(ufs_modules[i]) do
    local env_version_name = string.gsub(name, "-", "_") .. "_ver"
    load(pathJoin(name, os.getenv(env_version_name) or default_version))
  end
end

load("rocoto")

unload("cray-libsci")

setenv("CMAKE_C_COMPILER", "cc")
setenv("CMAKE_CXX_COMPILER", "CC")
setenv("CMAKE_Fortran_COMPILER", "ftn")
setenv("CMAKE_Platform", "gaea_c5.intel")
