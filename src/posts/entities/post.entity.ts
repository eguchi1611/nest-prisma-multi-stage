import { Post as PostType } from '@prisma/client';

export class Post implements PostType {
  id: number;
  content: string;
}
