# A chromosome contains a number of genes
# It consists out of mappings from indices (allelles) to values (genes).

def randint(max)
  if max == 0 then
    return 0
  else
    return (rand*max*10).to_int%max
  end
end

class Chromosome
  def initialize(genes)
    @genes=genes
  end
  def get_genes
    return @genes
  end
  def set_genes(value)
    @genes = value
  end  
  def mutate(index,gene)
    if index < @genes.size then
      @genes[index] = gene
    end
    return nil
  end
  def random_mutate
    index_new = randint(@genes.size)
    index_old = randint(@genes.size)
    gene = @genes[index_old]
    self.mutate(index_new,gene)
    return nil
  end
  def crossover(otherChromosome,index)
    ownBegin = @genes.first(index)
    otherBegin = otherChromosome.get_genes.first(index)
    ownEnd = @genes.last(@genes.size-index)
    otherEnd = otherChromosome.get_genes.last(otherChromosome.get_genes.size-index)
    @genes = ownBegin + otherEnd
    otherChromosome.set_genes(otherBegin + ownEnd)
    return nil
  end
  def random_crossover(otherChromosome)
    index = randint(@genes.size)
    self.crossover(otherChromosome,index)
  end
  def to_s
    return @genes.to_s
  end
  def dup
    return Chromosome.new(@genes.dup)
  end
end

