##############################################################################
##
## Matrix constructors
##
##############################################################################

for (f, basef) in ((:deye, :eye), )
    @eval begin
        ($f)(n::Int) = DataArray(($basef)(n), falses(n, n))
        ($f)(n::Int, p::Int) = DataArray(($basef)(n, p), falses(n, p))
    end
end
for (f, basef) in ((:ddiagm, :diagm), )
    @eval begin
        ($f)(vals::Vector) = DataArray(($basef)(vals), falses(length(vals), length(vals)))
    end
end

##############################################################################
##
## Extract the matrix diagonal
##
##############################################################################

function diag{T}(dm::DataMatrix{T})
    return DataArray(diag(dm.data), diag(dm.na))
end

##############################################################################
##
## Size information
##
##############################################################################

nrow{T}(dm::DataMatrix{T}) = size(dm, 1)
ncol{T}(dm::DataMatrix{T}) = size(dm, 2)

function matrix{T}(dm::DataMatrix{T})
    if any_na(dm)
        error("Can't convert a DataMatrix with missing entries")
    else
        return dm.data
    end
end
