{-# OPTIONS_GHC -w #-}
{-# OPTIONS -fglasgow-exts -cpp #-}
module Parser where

import Token
import Expr

import Data.String.Utils (join)
import qualified Data.Array as Happy_Data_Array
import qualified GHC.Exts as Happy_GHC_Exts

-- parser produced by Happy Version 1.18.10

newtype HappyAbsSyn t4 t5 t6 = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn4 :: t4 -> (HappyAbsSyn t4 t5 t6)
happyIn4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn t4 t5 t6) -> t4
happyOut4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyIn5 :: t5 -> (HappyAbsSyn t4 t5 t6)
happyIn5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn t4 t5 t6) -> t5
happyOut5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: t6 -> (HappyAbsSyn t4 t5 t6)
happyIn6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn t4 t5 t6) -> t6
happyOut6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyInTok :: (Token) -> (HappyAbsSyn t4 t5 t6)
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn t4 t5 t6) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\xf3\x01\xf3\x01\xf3\x01\xee\x00\xf3\x01\xf3\x01\xf3\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf4\xff\xcb\xff\xe1\x01\xd1\x01\xea\xff\xf3\x01\x44\x02\xbf\x00\x90\x00\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xf3\x01\xa2\x01\x73\x01\x44\x01\x15\x01\xe6\x00\xb7\x00\x88\x00\x59\x00\x2a\x00\xf3\x01\xf3\x01\x00\x00\xf9\xff\x30\x02\xf3\x01\xfb\xff\x00\x00\xf3\x01\x61\x00\x03\x00\xf3\x01\x00\x00\x1c\x02\x32\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xe7\x00\xd3\x00\xcd\x00\x00\x00\xbc\x00\xb8\x00\xa4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x8d\x00\x89\x00\x74\x00\x6f\x00\x5e\x00\x5a\x00\x45\x00\x40\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x17\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x0c\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\xfa\xff\xfe\xff\x00\x00\x00\x00\x00\x00\xea\xff\xe9\xff\xeb\xff\xe7\xff\xe6\xff\xe8\xff\xe5\xff\xfa\xff\xfd\xff\x00\x00\x00\x00\xfe\xff\xfe\xff\xfe\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf1\xff\xf2\xff\xf3\xff\xf4\xff\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xf0\xff\x00\x00\x00\x00\xf9\xff\x00\x00\xfe\xff\x00\x00\xec\xff\xed\xff\x00\x00\xfe\xff\xfe\xff\x00\x00\xee\xff\xfe\xff\xfe\xff\xef\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x06\x00\x18\x00\x08\x00\x00\x00\x01\x00\x02\x00\x0c\x00\x00\x00\x3e\x00\x02\x00\x08\x00\x00\x00\x19\x00\x02\x00\x14\x00\x15\x00\xff\xff\x17\x00\x1a\x00\x19\x00\x1a\x00\x00\x00\x00\x00\x02\x00\x02\x00\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\x33\x00\x02\x00\x33\x00\x00\x00\x06\x00\x02\x00\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\x00\x00\x17\x00\x02\x00\x19\x00\x1a\x00\x00\x00\x14\x00\x02\x00\xff\xff\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\xff\xff\x02\x00\x33\x00\x00\x00\x06\x00\x02\x00\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\x00\x00\x17\x00\x02\x00\x19\x00\x1a\x00\x00\x00\x14\x00\x02\x00\xff\xff\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\xff\xff\x02\x00\x33\x00\x00\x00\x06\x00\x02\x00\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\x00\x00\x17\x00\x02\x00\x19\x00\x1a\x00\xff\xff\x00\x00\x15\x00\x02\x00\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\xff\xff\x02\x00\x33\x00\x00\x00\x06\x00\x02\x00\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\x00\x00\x17\x00\x02\x00\x19\x00\x1a\x00\xff\xff\x00\x00\x15\x00\x02\x00\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x00\x00\xff\xff\x02\x00\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\x06\x00\xff\xff\x08\x00\x38\x00\x39\x00\x3a\x00\x0c\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\x14\x00\x15\x00\x06\x00\x17\x00\xff\xff\x19\x00\x1a\x00\xff\xff\x0c\x00\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x06\x00\x19\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0c\x00\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\xff\xff\xff\xff\xff\xff\xff\xff\x38\x00\x39\x00\x3a\x00\x19\x00\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x38\x00\x39\x00\x3a\x00\xff\xff\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x40\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x38\x00\x39\x00\x3a\x00\xff\xff\x3c\x00\x3d\x00\x3e\x00\x3f\x00\x17\x00\xff\xff\xff\xff\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x17\x00\xff\xff\xff\xff\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\x17\x00\xff\xff\xff\xff\x1a\x00\xff\xff\xff\xff\xff\xff\xff\xff\x33\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\xec\xff\x2d\x00\xec\xff\x02\x00\x2a\x00\x2b\x00\xec\xff\x02\x00\x11\x00\x35\x00\x33\x00\x02\x00\x12\x00\x34\x00\xec\xff\xec\xff\x00\x00\x16\x00\x2f\x00\xec\xff\xec\xff\x02\x00\x02\x00\x2d\x00\x30\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x02\x00\x30\x00\x31\x00\xec\xff\x02\x00\xf0\xff\x1e\x00\xf0\xff\xec\xff\xec\xff\xec\xff\xf0\xff\xec\xff\xec\xff\xec\xff\xec\xff\xec\xff\x00\x00\x00\x00\xf0\xff\xf0\xff\x02\x00\x16\x00\x1f\x00\xf0\xff\xf0\xff\x02\x00\x37\x00\x20\x00\x00\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x02\x00\x00\x00\x21\x00\xf0\xff\x02\x00\xf8\xff\x22\x00\xf8\xff\xf0\xff\xf0\xff\xf0\xff\xf8\xff\xf0\xff\xf0\xff\xf0\xff\xf0\xff\xf0\xff\x00\x00\x00\x00\xf8\xff\xf8\xff\x02\x00\x16\x00\x23\x00\xf8\xff\xf8\xff\x02\x00\x34\x00\x24\x00\x00\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x02\x00\x00\x00\x25\x00\xf8\xff\x02\x00\xf7\xff\x26\x00\xf7\xff\xf8\xff\xf8\xff\xf8\xff\xf7\xff\xf8\xff\xf8\xff\xf8\xff\xf8\xff\xf8\xff\x00\x00\x00\x00\xf7\xff\xf7\xff\x02\x00\x16\x00\x0f\x00\xf7\xff\xf7\xff\x00\x00\x02\x00\x28\x00\x12\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x02\x00\x00\x00\x13\x00\xf7\xff\x02\x00\xf6\xff\x14\x00\xf6\xff\xf7\xff\xf7\xff\xf7\xff\xf6\xff\xf7\xff\xf7\xff\xf7\xff\xf7\xff\xf7\xff\x00\x00\x00\x00\xf6\xff\xf6\xff\x02\x00\x16\x00\x0f\x00\xf6\xff\xf6\xff\x00\x00\x02\x00\x29\x00\x03\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0e\x00\x00\x00\x03\x00\xf6\xff\x00\x00\xf5\xff\x00\x00\xf5\xff\xf6\xff\xf6\xff\xf6\xff\xf5\xff\xf6\xff\xf6\xff\xf6\xff\xf6\xff\xf6\xff\x00\x00\x00\x00\xf5\xff\xf5\xff\x00\x00\x16\x00\x00\x00\xf5\xff\xf5\xff\x00\x00\x00\x00\x00\x00\x00\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\xf5\xff\x00\x00\xf4\xff\x00\x00\xf4\xff\xf5\xff\xf5\xff\xf5\xff\xf4\xff\xf5\xff\xf5\xff\xf5\xff\xf5\xff\xf5\xff\x00\x00\x00\x00\xf4\xff\xf4\xff\x00\x00\x16\x00\x00\x00\xf4\xff\xf4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf4\xff\x00\x00\xf3\xff\x00\x00\xf3\xff\xf4\xff\xf4\xff\xf4\xff\xf3\xff\xf4\xff\xf4\xff\xf4\xff\xf4\xff\xf4\xff\x00\x00\x00\x00\xf3\xff\xf3\xff\x00\x00\x16\x00\x00\x00\xf3\xff\xf3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf3\xff\x00\x00\xf2\xff\x00\x00\xf2\xff\xf3\xff\xf3\xff\xf3\xff\xf2\xff\xf3\xff\xf3\xff\xf3\xff\xf3\xff\xf3\xff\x00\x00\x00\x00\xf2\xff\xf2\xff\x00\x00\x16\x00\x00\x00\xf2\xff\xf2\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf2\xff\x00\x00\xf1\xff\x00\x00\xf1\xff\xf2\xff\xf2\xff\xf2\xff\xf1\xff\xf2\xff\xf2\xff\xf2\xff\xf2\xff\xf2\xff\x00\x00\x00\x00\xf1\xff\xf1\xff\x00\x00\x16\x00\x00\x00\xf1\xff\xf1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf1\xff\x00\x00\xfd\xff\x00\x00\xfd\xff\xf1\xff\xf1\xff\xf1\xff\xfd\xff\xf1\xff\xf1\xff\xf1\xff\xf1\xff\xf1\xff\x00\x00\x00\x00\xfd\xff\xfd\xff\x05\x00\x16\x00\x00\x00\xfd\xff\xfd\xff\x00\x00\x06\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x05\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\xfd\xff\xfd\xff\x07\x00\xfd\xff\xfd\xff\xfd\xff\xfd\xff\xfd\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x16\x00\x00\x00\x00\x00\xfb\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\xfc\xff\x00\x00\x00\x00\x00\x00\x00\x00\xfb\xff\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00\x00\x00\x00\x2a\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xff\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 26) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26)
	]

happy_n_terms = 65 :: Int
happy_n_nonterms = 3 :: Int

happyReduce_1 = happySpecReduce_1  0# happyReduction_1
happyReduction_1 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn4
		 (happy_var_1
	)}

happyReduce_2 = happySpecReduce_2  0# happyReduction_2
happyReduction_2 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn4
		 (Exprs ((case happy_var_1 of { Exprs v -> v; a -> [a] })++[happy_var_2])
	)}}

happyReduce_3 = happySpecReduce_1  1# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn5
		 (happy_var_1
	)}

happyReduce_4 = happySpecReduce_3  1# happyReduction_4
happyReduction_4 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn5
		 (Params ((case happy_var_1 of { Params v -> v; a -> [a] })++[happy_var_3])
	)}}

happyReduce_5 = happySpecReduce_1  2# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn6
		 (happy_var_1
	)}

happyReduce_6 = happySpecReduce_3  2# happyReduction_6
happyReduction_6 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn6
		 (happy_var_2
	)}

happyReduce_7 = happySpecReduce_3  2# happyReduction_7
happyReduction_7 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Eq happy_var_1 happy_var_3
	)}}

happyReduce_8 = happySpecReduce_3  2# happyReduction_8
happyReduction_8 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Neq happy_var_1 happy_var_3
	)}}

happyReduce_9 = happySpecReduce_3  2# happyReduction_9
happyReduction_9 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Seq happy_var_1 happy_var_3
	)}}

happyReduce_10 = happySpecReduce_3  2# happyReduction_10
happyReduction_10 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp NotSeq happy_var_1 happy_var_3
	)}}

happyReduce_11 = happySpecReduce_3  2# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Gte happy_var_1 happy_var_3
	)}}

happyReduce_12 = happySpecReduce_3  2# happyReduction_12
happyReduction_12 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Lte happy_var_1 happy_var_3
	)}}

happyReduce_13 = happySpecReduce_3  2# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Gt happy_var_1 happy_var_3
	)}}

happyReduce_14 = happySpecReduce_3  2# happyReduction_14
happyReduction_14 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (EqOp Lt happy_var_1 happy_var_3
	)}}

happyReduce_15 = happySpecReduce_3  2# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { (TokenOp happy_var_2) -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (Op (opEnc happy_var_2) happy_var_1 happy_var_3
	)}}}

happyReduce_16 = happyReduce 7# 2# happyReduction_16
happyReduction_16 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut6 happy_x_4 of { happy_var_4 -> 
	case happyOut6 happy_x_6 of { happy_var_6 -> 
	happyIn6
		 (If happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_17 = happyReduce 5# 2# happyReduction_17
happyReduction_17 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut6 happy_x_4 of { happy_var_4 -> 
	happyIn6
		 (While happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_18 = happyReduce 4# 2# happyReduction_18
happyReduction_18 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { (TokenIdnt happy_var_1) -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn6
		 (Fun happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_19 = happyReduce 4# 2# happyReduction_19
happyReduction_19 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { (TokenClassV happy_var_1) -> 
	case happyOutTok happy_x_2 of { (TokenIdnt happy_var_2) -> 
	case happyOut6 happy_x_4 of { happy_var_4 -> 
	happyIn6
		 (Assign happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_20 = happySpecReduce_1  2# happyReduction_20
happyReduction_20 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TokenString happy_var_1) -> 
	happyIn6
		 (Str happy_var_1
	)}

happyReduce_21 = happySpecReduce_1  2# happyReduction_21
happyReduction_21 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TokenFloat happy_var_1) -> 
	happyIn6
		 (Float happy_var_1
	)}

happyReduce_22 = happySpecReduce_1  2# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TokenInt happy_var_1) -> 
	happyIn6
		 (Num happy_var_1
	)}

happyReduce_23 = happySpecReduce_1  2# happyReduction_23
happyReduction_23 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TokenIdnt happy_var_1) -> 
	happyIn6
		 (Var happy_var_1
	)}

happyReduce_24 = happySpecReduce_1  2# happyReduction_24
happyReduction_24 happy_x_1
	 =  happyIn6
		 (Bool True
	)

happyReduce_25 = happySpecReduce_1  2# happyReduction_25
happyReduction_25 happy_x_1
	 =  happyIn6
		 (Bool False
	)

happyReduce_26 = happySpecReduce_1  2# happyReduction_26
happyReduction_26 happy_x_1
	 =  case happyOutTok happy_x_1 of { (TokenClassV happy_var_1) -> 
	happyIn6
		 (Type happy_var_1
	)}

happyNewToken action sts stk [] =
	happyDoAction 64# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	TokenExport -> cont 1#;
	TokenImport -> cont 2#;
	TokenInclude -> cont 3#;
	TokenTypedef -> cont 4#;
	TokenIn -> cont 5#;
	TokenIf -> cont 6#;
	TokenElif -> cont 7#;
	TokenElse -> cont 8#;
	TokenMaybe -> cont 9#;
	TokenUnless -> cont 10#;
	TokenFor -> cont 11#;
	TokenWhile -> cont 12#;
	TokenLoop -> cont 13#;
	TokenTry -> cont 14#;
	TokenCatch -> cont 15#;
	TokenAnyway -> cont 16#;
	TokenRaise -> cont 17#;
	TokenClass -> cont 18#;
	TokenDef -> cont 19#;
	TokenEnd -> cont 20#;
	TokenArrow -> cont 21#;
	TokenGenerate -> cont 22#;
	TokenOp happy_dollar_dollar -> cont 23#;
	TokenAssign -> cont 24#;
	TokenLParen -> cont 25#;
	TokenRParen -> cont 26#;
	TokenLBrace -> cont 27#;
	TokenRBrace -> cont 28#;
	TokenLSqBrace -> cont 29#;
	TokenRSqBrace -> cont 30#;
	TokenTilde -> cont 31#;
	TokenEq -> cont 32#;
	TokenNeq -> cont 33#;
	TokenSeq -> cont 34#;
	TokenNotSeq -> cont 35#;
	TokenGte -> cont 36#;
	TokenLte -> cont 37#;
	TokenGt -> cont 38#;
	TokenLt -> cont 39#;
	TokenIntersect -> cont 40#;
	TokenUnion -> cont 41#;
	TokenSubset -> cont 42#;
	TokenNotSubset -> cont 43#;
	TokenSuperset -> cont 44#;
	TokenNotSuperset -> cont 45#;
	TokenElement -> cont 46#;
	TokenNotElement -> cont 47#;
	TokenContain -> cont 48#;
	TokenNotContain -> cont 49#;
	TokenForAll -> cont 50#;
	TokenComma -> cont 51#;
	TokenDot -> cont 52#;
	TokenGuil -> cont 53#;
	TokenLambda -> cont 54#;
	TokenNL -> cont 55#;
	TokenFloat happy_dollar_dollar -> cont 56#;
	TokenInt happy_dollar_dollar -> cont 57#;
	TokenString happy_dollar_dollar -> cont 58#;
	TokenVar happy_dollar_dollar -> cont 59#;
	TokenBool True -> cont 60#;
	TokenBool False -> cont 61#;
	TokenIdnt happy_dollar_dollar -> cont 62#;
	TokenClassV happy_dollar_dollar -> cont 63#;
	_ -> happyError' (tk:tks)
	}

happyError_ 64# tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

expr tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut4 x))

happySeq = happyDontSeq


opEnc :: String -> Binop
opEnc "+" = Add
opEnc "-" = Sub
opEnc "*" = Mul
opEnc "×" = Mul
opEnc "÷" = Div
opEnc "/" = Div
opEnc "^" = Pow
opEnc "%" = Div

parseError :: [Token] -> a
parseError tks = error $ "Parse error near " ++ (join " " $ map show tks)

parseExpr :: String -> Expr 
parseExpr = expr . scanTokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList





{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
	= {- nothing -}


	  case action of
		0#		  -> {- nothing -}
				     happyFail i tk st
		-1# 	  -> {- nothing -}
				     happyAccept i tk st
		n | (n Happy_GHC_Exts.<# (0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}

				     (happyReduceArr Happy_Data_Array.! rule) i tk st
				     where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
		n		  -> {- nothing -}


				     happyShift new_state i tk st
				     where (new_state) = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where (off)    = indexShortOffAddr happyActOffsets st
         (off_i)  = (off Happy_GHC_Exts.+# i)
	 check  = if (off_i Happy_GHC_Exts.>=# (0# :: Happy_GHC_Exts.Int#))
			then (indexShortOffAddr happyCheck off_i Happy_GHC_Exts.==#  i)
			else False
         (action)
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st

{-# LINE 130 "templates/GenericTemplate.hs" #-}


indexShortOffAddr (HappyA# arr) off =
	Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#





data HappyAddr = HappyA# Happy_GHC_Exts.Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 163 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let (i) = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
	 sts1@((HappyCons (st1@(action)) (_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@((HappyCons (st1@(action)) (_)))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@((HappyCons (st1@(action)) (_)))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

             (off) = indexShortOffAddr happyGotoOffsets st1
             (off_i) = (off Happy_GHC_Exts.+# nt)
             (new_state) = indexShortOffAddr happyTable off_i




happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where (off) = indexShortOffAddr happyGotoOffsets st
         (off_i) = (off Happy_GHC_Exts.+# nt)
         (new_state) = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail 0# tk old_st _ stk@(x `HappyStk` _) =
     let (i) = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
	happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
