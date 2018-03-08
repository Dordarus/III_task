huxley = [
  [ "Brave New World", "Dystopian novel", 1931, "The novel opens in the World State city of London in AF 632 (AD 2540 in the Gregorian calendar), where citizens are engineered through artificial wombs and childhood indoctrination programs into predetermined classes (or castes) based on intelligence and labour."],
  [ "Island", "Utopian novel", 1962, "Englishman William Asquith 'Will' Farnaby deliberately wrecks his boat on the Polynesian shores of the Kingdom of Pala, thus forcing his entry to this otherwise 'forbidden island'. Farnaby, a journalist, political huckster, and lackey for the oil baron Lord Joseph \"Joe\" Aldehyde, is tasked with persuading the island's current queen—the Rani—to sell Aldehyde rights to Pala's untapped oil assets."]
]

orwell = [
    [ "1984", "Dystopian novel", 1949, "The novel is set in Airstrip One, formerly Great Britain, a province of the superstate Oceania, whose residents are victims of perpetual war, omnipresent government surveillance and public manipulation."],
    [ "Animal Farm", "allegorical novella", 1945, "Old Major, the old boar on the Mayor Farm, summons the animals on the farm together for a meeting, during which he refers to humans as \"enemies\" and teaches the animals a revolutionary song called \"Beasts of England\."]
]

sacks = [
    [ "The Man Who Mistook His Wife for a Hat", "Case history", 1985, "Book by neurologist Oliver Sacks describing the case histories of some of his patients. Sacks chose the title of the book from the case study of one of his patients which he names \"Dr. P\" that suffers from visual agnosia."],
    [ "Hallucinations", "Case history", 2012, "In Hallucinations, Sacks recounts stories of hallucinations and other mind-altering episodes of both his patients and himself and uses them in an attempt to elucidate certain features and structures of the brain including his own migraine headaches."]
]

huxley.each do |title, genre, year, plot|
    User.second.books.create( title: title, genre: genre, year: year, plot: plot)
end

orwell.each do |title, genre, year, plot|
    User.third.books.create( title: title, genre: genre, year: year, plot: plot)
end

sacks.each do |title, genre, year, plot|
    User.fourth.books.create( title: title, genre: genre, year: year, plot: plot)
end