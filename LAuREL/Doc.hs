module LAuREL.Doc where

	import LAuREL.Types
	import Data.String.Utils

	-- |Converts what the parser parsed into definition list
	docify :: Expr -> Manual
	docify (Root e) =
		docify' e (Defs [])
		where
			docify' :: Exprs -> Manual -> Manual
			docify' [] (Defs d) = (Defs $ reverse d)
			docify' (xl@((Comment Nothing a):xs)) (Defs d) = 
				docify' xs (Defs (Global a:d))
			docify' (xl@((Comment (Just "author") a):xs)) (Defs d) = 
				docify' xs (Defs (Author a:d))
			docify' (xl@((Comment (Just "date") a):xs)) (Defs d) = 
				docify' xs (Defs (Date a:d))
			docify' (xl@((Comment (Just "version") a):xs)) (Defs d) = 
				docify' xs (Defs (Version a:d))
			docify' (xl@((Comment (Just "license") a):xs)) (Defs d) = 
				docify' xs (Defs (License a:d))
			docify' (xl@((Comment (Just "name") a):xs)) (Defs d) = 
				docify' xs (Defs (ProjectName a:d))
			docify' (xl@((Fun name help types _ _):xs)) (Defs d) = 
				docify' xs (Defs (Method name types (case help of 
														Just a -> a
														Nothing -> ""):d))
			docify' (_:xs) d =
				docify' xs d

	-- |Output definition to into Markdown
	markdownify :: Manual -> String
	markdownify (Defs a) =
			(if
				(length $ projectname a) > 0
			then
				"# "++(last $ projectname a)
			else
				"# LAuREL project")++(if (length $ version a) > 0 then " ("++(last $ version a)++")" else "")++"\n\n"++
			(if 
				(length $ authors a) > 0
			then
				"## Authors\n\n"++
				(join "\n" $ map (\a -> "-   "++a) $ authors a)++
				"\n"
			else
				"")++"\n"++
			(if 
				(length $ license a) > 0
			then
				"## License\n\n"++
				"This is distributed under "++(last $ license a)++"\n"
			else
				"")++"\n"++
			(if 
				(length $ globals a) > 0
			then
				"## Notes\n\n"++
				(join "\n\n" $ globals a)
			else
				"")++"\n"++
			(if 
				(length $ defs a) > 0 
			then 
				"## Methods\n\n"
			else
				"\n")++
			(join "\n\n------\n\n" $ map (\(Method name types help) -> "### "++name++"\n\n```\n"++name++" : "++(join " -> " types)++"\n```\n\n"++help) $ defs a)

		where
			projectname [] = 
				[]
			projectname ((ProjectName a):xs) = 
				a:(projectname xs)
			projectname (_:xs) = 
				projectname xs
			globals [] = 
				[]
			globals ((Global a):xs) = 
				a:(globals xs)
			globals (_:xs) = 
				globals xs
			authors [] = 
				[]
			authors ((Author a):xs) = 
				a:(authors xs)
			authors (_:xs) = 
				authors xs
			version [] = 
				[]
			version ((Version a):xs) = 
				a:(version xs)
			version (_:xs) = 
				version xs
			license [] = 
				[]
			license ((License a):xs) = 
				a:(license xs)
			license (_:xs) = 
				license xs
			defs [] = 
				[]
			defs ((m@(Method _ _ _)):xs) = 
				m:(defs xs)
			defs (_:xs) =
				defs xs